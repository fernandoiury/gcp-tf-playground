resource "google_compute_firewall" "ssh-from-office" {
  name    = "${var.project_id}-${var.environment}-allow-ssh-from-office"
  network = module.vpc.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.office_ips
  target_tags   = ["${var.project_id}-${var.environment}-bastion"]
}

resource "google_compute_firewall" "bastion-internal" {
  name    = "${var.project_id}-${var.environment}-bastion-internal"
  network = module.vpc.network_name

  allow {
    protocol = "all"
  }

  source_tags = ["${var.project_id}-${var.environment}-bastion"]
  target_tags = ["${var.project_id}-${var.environment}-bastion"]
}

resource "google_compute_firewall" "all-from-bastion" {
  name    = "${var.project_id}-${var.environment}-all-from-bastion"
  network = module.vpc.network_name

  allow {
    protocol = "all"
  }

  source_tags = ["${var.project_id}-${var.environment}-bastion"]
}

resource "google_compute_firewall" "gke-internal" {
  name    = "${var.project_id}-${var.environment}-gke-internal"
  network = module.vpc.network_name

  allow {
    protocol = "all"
  }

  source_tags = ["${var.project_id}-${var.environment}-gke"]
  target_tags = ["${var.project_id}-${var.environment}-gke"]
}

resource "google_compute_firewall" "access-from-workers" {
  name    = "${var.project_id}-${var.environment}-all-from-gke"
  network = module.vpc.network_name

  allow {
    protocol = "all"
  }

  source_tags = ["${var.project_id}-${var.environment}-gke"]
}

resource "google_compute_firewall" "cassandra-internal" {
  name    = "${var.project_id}-${var.environment}-cassandra-internal"
  network = module.vpc.network_name

  allow {
    protocol = "all"
  }

  source_tags = ["${var.project_id}-${var.environment}-cassandra"]
  target_tags = ["${var.project_id}-${var.environment}-cassandra"]
}

resource "google_compute_firewall" "zookeeper-internal" {
  name    = "${var.project_id}-${var.environment}-zookeeper-internal"
  network = module.vpc.network_name

  allow {
    protocol = "all"
  }

  source_tags = ["${var.project_id}-${var.environment}-zookeeper"]
  target_tags = ["${var.project_id}-${var.environment}-zookeeper"]
}

resource "google_compute_firewall" "kafka-internal" {
  name    = "${var.project_id}-${var.environment}-kafka-internal"
  network = module.vpc.network_name

  allow {
    protocol = "all"
  }

  source_tags = ["${var.project_id}-${var.environment}-kafka"]
  target_tags = ["${var.project_id}-${var.environment}-kafka"]
}

resource "google_compute_firewall" "elasticsearch-internal" {
  name    = "${var.project_id}-${var.environment}-elasticsearch-internal"
  network = module.vpc.network_name

  allow {
    protocol = "all"
  }

  source_tags = ["${var.project_id}-${var.environment}-elasticsearch"]
  target_tags = ["${var.project_id}-${var.environment}-elasticsearch"]
}

resource "google_compute_firewall" "dataproc-to-cassandra" {
  name    = "${var.project_id}-${var.environment}-dataproc-to-cassandra"
  network = module.vpc.network_name

  allow {
    protocol = "tcp"
    ports    = ["9042"]
  }

  source_tags = ["${var.project_id}-${var.environment}-dataproc"]
  target_tags = ["${var.project_id}-${var.environment}-cassandra"]
}

resource "google_compute_firewall" "dataproc-to-kafka" {
  name    = "${var.project_id}-${var.environment}-dataproc-to-kafka"
  network = module.vpc.network_name

  allow {
    protocol = "tcp"
    ports    = ["9092"]
  }

  source_tags = ["${var.project_id}-${var.environment}-dataproc"]
  target_tags = ["${var.project_id}-${var.environment}-kafka"]
}

resource "google_compute_firewall" "dataproc-to-zookeeper" {
  name    = "${var.project_id}-${var.environment}-dataproc-to-zookeeper"
  network = module.vpc.network_name

  allow {
    protocol = "tcp"
    ports    = ["2181"]
  }

  source_tags = ["${var.project_id}-${var.environment}-dataproc"]
  target_tags = ["${var.project_id}-${var.environment}-zookeeper"]
}

#resource "google_compute_firewall" "all-all-to-test" {
#  name    = "${var.project_id}-${var.environment}-allow-all"
#  network = module.vpc.network_name
#
#  allow {
#    protocol = "all"
#  }
#
#  source_ranges = [ var.vpc__subnet_gke_cidr ]
#}
